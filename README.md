# Middleman::ImageOptim

Automatic image optimizer for [Middleman](https://middlemanapp.com/) v4 using [image_optim](https://github.com/toy/image_optim) gem.

## Installation

Install [image optimizers supported by image_optim](https://github.com/toy/image_optim#binaries-installation), and then enable `middleman-image_optim` gem in your Middleman project.

```ruby
gem 'middleman-image_optim'
gem 'image_optim_pack'  # optional -- some optimizers can be installed with this gem
```

## Usage

Activate `image_optim` extension in your Middleman configuration. Refer to the [image_optim documentation](https://github.com/toy/image_optim#options) for available options.

```ruby
configure :build do
  activate :image_optim,
           cache_dir: File.join(__dir__, '.cache', 'image_optim'),
           jpegtran: true,
           optipng: true
end
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
