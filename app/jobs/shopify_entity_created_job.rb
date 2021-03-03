# frozen_string_literal: true

class ShopifyEntityCreatedJob < ApplicationJob
  queue_as :ecommerce_orchestrator_shopify_entity_created

  def perform(entity_id:, shopify_id:)
    entity_id = ShopifyEntity.find(entity_id)
    entity_id.update!(shopify_id: shopify_id)
  end
end
