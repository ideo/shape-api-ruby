module ShapeApiMocks
  def shape_api_collection_double(where: nil)
    allow(ShapeApi::Collection).to receive(:where).and_return(
      where || [shape_api_collection_instance],
    )
  end

  def shape_api_collection_card_double(where: nil, new: nil)
    allow(ShapeApi::CollectionCard).to receive(:where).and_return(
      where || [shape_api_collection_card_item_instance],
    )
    allow(ShapeApi::CollectionCard).to receive(:new).and_return(
      new || shape_api_collection_card_item_instance,
    )
    allow(ShapeApi::CollectionCard).to receive(:create_with_text_item).and_return(
      shape_api_collection_card_item_instance,
    )
  end

  def shape_api_role_double(where: nil, new: nil)
    allow(ShapeApi::Role).to receive(:create).and_return(
      true,
    )
    allow(ShapeApi::Role).to receive(:new).and_return(
      new || shape_api_role_instance,
    )
    allow(ShapeApi::Role).to receive(:where).and_return(
      where || [shape_api_role_instance],
    )
  end

  def shape_api_group_double(where: nil, new: nil)
    allow(ShapeApi::Group).to receive(:create).and_return(
      true,
    )
    allow(ShapeApi::Group).to receive(:where).and_return(
      where || [shape_api_group_instance],
    )
    allow(ShapeApi::Group).to receive(:new).and_return(
      new || shape_api_group_instance,
    )
  end

  def shape_api_organization_double(where: nil)
    allow(ShapeApi::Organization).to receive(:where).and_return(
      where || [shape_api_organization_instance],
    )
  end

  def shape_api_organization_instance(attrs = {})
    double('ShapeApi::Organization',
           {
             id: 1,
             external_id: 'CreativeDiffOrg_1',
             current_user_collection_id: 1,
           }.deep_merge(attrs),
          )
  end

  def shape_api_group_instance(attrs = {})
    double('ShapeApi::Group',
           {
             id: 1,
             external_id: 'CreativeDiffBuGroup_1',
             errors: [],
             save: true,
           }.deep_merge(attrs))
  end

  def shape_api_role_instance(attrs = {})
    double('ShapeApi::Role',
           {
             id: 1,
             name: 'editor',
             errors: [],
             groups: [],
             users: [],
             save: true,
             destroy: true,
           }.deep_merge(attrs))
  end

  def shape_api_collection_instance(attrs = {})
    double('ShapeApi::Collection',
           {
             new: true,
             save: true,
             update_attributes: true,
             external_id: 'CreativeDiffCollRecord_1',
             errors: [],
             id: 1,
           }.deep_merge(attrs))
  end

  def shape_api_item_instance(attrs = {})
    double('ShapeApi::Item',
           {
             new: true,
             save: true,
             update_attributes: true,
             errors: [],
             external_id: 'CreativeDiffItemRecord_1',
             id: 1,
           }.deep_merge(attrs))
  end

  def shape_api_collection_card_item_instance(attrs = {})
    double('ShapeApi::CollectionCard',
           shape_api_collection_card_attrs.deep_merge(
             record: shape_api_item_instance,
           ).deep_merge(attrs))
  end

  def shape_api_collection_card_collection_instance(attrs = {})
    double('ShapeApi::CollectionCard',
           shape_api_collection_card_attrs.deep_merge(
             record: shape_api_collection_instance,
           ).deep_merge(attrs))
  end

  def shape_api_collection_card_attrs
    {
      new: true,
      update_attributes: true,
      id: 1,
      save: true,
      errors: [],
    }
  end
end
