require 'middleman/image_optim/extension'

describe Middleman::ImageOptim::Extension do
  it 'inherits Middleman::Extension' do
    expect(described_class).to be < Middleman::Extension
  end

  let(:app) do
    Middleman::Application.new.tap do |app|
      logger = object_double(Middleman::Logger.singleton, level: log_level).as_null_object
      allow(app).to receive(:logger).and_return(logger)
    end
  end

  let(:log_level) { 1 }
  let(:options_hash) { {} }

  subject { described_class.new(app, options_hash) }

  describe '#initialize' do
    describe 'image_optim verbosity' do
      context 'when logger is verbose' do
        before { $stdout = $stderr = StringIO.new }
        after { $stdout, $stderr = STDOUT, STDERR }

        let(:log_level) { 0 }

        it do
          expect(subject.image_optim.verbose).to be_truthy
        end
      end

      context 'when logger is quiet enough' do
        let(:log_level) { 1 }

        it do
          expect(subject.image_optim.verbose).to be_falsy
        end
      end
    end

    describe 'image_optim optimizer options' do
      let(:jpegtran_opts) { {progressive: false} }
      let(:options_hash) { {jpegtran: jpegtran_opts} }

      it do
        expect(ImageOptim).to receive(:new).with(a_hash_including(jpegtran: jpegtran_opts))
        subject
      end
    end
  end

  describe '#manipulate_resource_list' do
    let(:source_dir) { Pathname(__dir__) + '../../../../example/source' }
    let(:source_files) { %w[images/MtFuji_FujiCity.jpg index.html.md] }

    let!(:resources) do
      source_files.map do |file|
        Middleman::Sitemap::Resource.new(app.sitemap, file, (source_dir + file).to_s)
      end
    end

    let(:options_hash) { {jpegtran: true} }

    it 'optimizes image' do
      source_files.each do |file|
        expect(subject.image_optim).to receive(:optimize_image).with((source_dir + file).to_s).and_call_original
      end
      expect_any_instance_of(ImageOptim::Worker::Jpegtran).to receive(:optimize).with(source_dir + source_files[0], anything).and_call_original

      result = subject.manipulate_resource_list(resources)

      expect(result[0]).not_to eq resources[0]
      expect(Pathname(result[0].source_file)).to exist

      expect(result[1]).to eq resources[1]
    end
  end
end
