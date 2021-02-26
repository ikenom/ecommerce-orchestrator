# frozen_string_literal: true

require "active_support/concern"

module CmsEntity
  extend ActiveSupport::Concern

  included do
    include Mongoid::Document

    field :cms_id, type: String
    index({ cms_id: 1 }, { unique: true })
  end
end
