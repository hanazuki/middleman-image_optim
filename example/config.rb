configure :build do
  activate :image_optim,
           cache_dir: File.join(__dir__, '.cache', 'image_optim'),
           jpegtran: true
end
