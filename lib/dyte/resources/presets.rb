module Dyte
  class PresetsResource < Resource
    def list(**params)
      response = get_request("presets", params: params)
      Collection.from_response(response, type: Preset)
    end

    def create(**attributes)
      Preset.new post_request("presets", body: attributes).body.dig("data")
    end

    def fetch(preset_id:)
      Preset.new get_request("presets/#{preset_id}").body.dig("data")
    end

    def delete(preset_id:)
      Preset.new delete_request("presets/#{preset_id}").body.dig("data")
    end

    def update(preset_id:, **attributes)
      Preset.new patch_request("presets/#{preset_id}", body: attributes).body.dig("data")
    end
  end
end
