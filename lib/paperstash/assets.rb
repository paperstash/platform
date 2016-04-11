module PaperStash
  #
  ASSETS = %w{bundle.js bundle.css}.freeze

  #
  module Assets
    #
    def self.manifest
      manifest = lambda {
        require 'digest/sha1'
        Hash[ASSETS.map do |asset|
          # OPTIMIZE(mtwilliams): Stream contents into hash?
          contents = File.read("#{PaperStash.root}/public/assets/#{asset}")
          hash = Digest::SHA1.hexdigest(contents)
          [asset, {hash: hash}]
        end]
      }

      if PaperStash.env.production?
        # Cache our manifest in production.
        @manifest ||= manifest.call()
      else
        manifest.call()
      end
    end

    #
    def self.busted(path)
      if info = self.manifest[path]
        "/assets/#{path}?#{info[:hash]}"
      else
        "/assets/#{path}"
      end
    end
  end
end
