require_relative 'image_optim/version'

Middleman::Extensions.register(:image_optim) do
  require_relative 'image_optim/extension'
  Middleman::ImageOptim::Extension
end
