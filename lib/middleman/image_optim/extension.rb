require 'image_optim'

module Middleman
  module ImageOptim
    class Extension < Middleman::Extension

      option :nice
      option :threads
      option :pack
      option :skip_missing_workers
      option :allow_lossy
      option :cache_dir
      option :cache_worker_digests

      ::ImageOptim::Worker.klasses.map(&:bin_sym).each do |worker|
        option worker, false, "Options for #{worker}"
      end

      attr_reader :image_optim

      def initialize(*)
        super
        @image_optim = ::ImageOptim.new(options.to_h.merge(verbose: logger.level == 0))
      end

      def manipulate_resource_list(resources)
        optimized_files = image_optim.optimize_images(resources.map(&:source_file))

        resources.zip(optimized_files).map do |resource, (_, optimized_file)|
          if optimized_file
            reduction = optimized_file.original_size - optimized_file.size
            if reduction > 0
              logger.debug "#{resource.path} reduced #{reduction / 1024}KB (#{'%.2f' % (100.0 * reduction / optimized_file.original_size)}%)"
              Middleman::Sitemap::Resource.new(app.sitemap, resource.path, optimized_file.to_s)
            end
          end or resource
        end
      end
    end
  end
end
