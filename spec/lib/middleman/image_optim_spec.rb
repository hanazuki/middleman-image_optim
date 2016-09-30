describe Middleman::ImageOptim do
  it 'has a version number' do
    expect(Middleman::ImageOptim::VERSION).not_to be nil
  end

  it 'registers image_optim extension' do
    expect(Middleman::Extensions.load(:image_optim)).to eq Middleman::ImageOptim::Extension
  end
end
