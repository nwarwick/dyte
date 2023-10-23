module Dyte
  class OrganizationsResource < Resource
    def create(**attributes)
      Organization.new post_request("orgs", body: attributes).body.dig("data")
    end

    def fetch(organization_id:)
      Organization.new get_request("orgs/#{organization_id}").body.dig("data")
    end

    def update(organization_id:, **attributes)
      Organization.new patch_request("orgs/#{organization_id}", body: attributes).body.dig("data")
    end
  end
end
