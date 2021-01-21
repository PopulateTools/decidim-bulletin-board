# frozen_string_literal: true

module Types
  module MessageInterface
    include Types::BaseInterface

    field :id, ID, null: false
    field :election, Types::ElectionType, null: false
    field :client, Types::ClientType, null: false
    field :message_id, String, null: false
    field :signed_data, String, null: true do
      def resolve(parent, _args, context)
        log_entry = parent.object
        log_entry.signed_data if log_entry.visible_for_all? || log_entry.election.authority.api_key == context[:api_key]
      end
    end
  end
end
