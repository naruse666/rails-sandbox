RSpec.shared_examples 'validatable' do
  context '正常な値の場合' do
    it 'valid' do
      expect(subject).to be_valid
    end
  end
end

RSpec.shared_examples 'required_attr' do |attribute|
  context "#{attribute}が空の場合" do
    before { subject.public_send("#{attribute}=", nil) }

    it 'invalid' do
      expect(subject).not_to be_valid
    end

    it "#{attribute}のエラーメッセージがある" do
      subject.valid?
      expect(subject.errors[attribute]).not_to be_empty
    end
  end
end
