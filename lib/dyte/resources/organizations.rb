module Dyte
  class OrganizationsResource < Resource
    def create(**attributes)
      Organization.new post_request("orgs", body: attributes).body.dig("data")
    end
  end
end
