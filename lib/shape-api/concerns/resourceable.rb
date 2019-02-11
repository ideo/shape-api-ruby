module ShapeApi
  module Resourceable
    extend ActiveSupport::Concern

    # Available params for both methods:
    # - [user_ids] - array of Shape user ids to add/remove
    # - [group_ids] - array of Shape group ids to add/remove
    # - is_switching - T/F - if user is merely switching roles rather than a new role
    #   - default true
    # - send_invites - T/F - send invitations to users (only applicable when creating a new role)
    #   - default true

    # NOTE: if you call create_role and send_invites for user(s) that were already added to the resource,
    # they will still get an email invitation (it doesn't care that they already had access)
    def create_role(role_name, params = {})
      change_role_access(role_name, user_emails_to_ids(params), :post)
    end

    def delete_role(role_name, params = {})
      change_role_access(role_name, user_emails_to_ids(params), :delete)
    end

    private

    def user_emails_to_ids(params)
      return params unless params[:user_emails].present?

      user_ids = params[:user_ids] || []
      if params[:user_emails].present?
        users = ShapeApi::User.create_from_emails(emails: params.delete(:user_emails))
        user_ids = (user_ids + users.pluck(:id)).uniq
      end
      params.merge(
        user_ids: user_ids,
      )
    end

    # adapted from json_api_client resource member_endpoint
    def change_role_access(role_name, params, method)
      error = false
      if is_a? ShapeApi::Group
        error = true unless %i[admin member].include? role_name.to_sym
      else
        error = true unless %i[editor viewer].include? role_name.to_sym
      end
      if error
        errors.messages[:role_name] = ['invalid']
        return false
      end

      request_params = params.merge(
        role: { name: role_name },
      )
      if method == :delete
        request_params = { _jsonapi: request_params }
      end
      request_params[self.class.primary_key] = attributes.fetch(self.class.primary_key)
      self.class.requestor.custom(
        'roles',
        { request_method: method },
        request_params,
      )
    end
  end
end
