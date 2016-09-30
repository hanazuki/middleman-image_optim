describe 'image_optim', type: :feature do
  describe 'image' do
    it 'optimizes JPEG image' do
      get '/images/MtFuji_FujiCity.jpg'
      expect(last_response.length).to be < (middleman.source_dir + 'images/MtFuji_FujiCity.jpg').size
    end
  end
end
