require 'rspec/core'

RSpec.describe 'Hash' do
  it 'contains exactly' do
    expect({ a: 1, b: 2 }).to eq({ b: 2, a: 1 })
  end

  let(:external_resources) {
    {
      dump_json: [
        {
          unique_key: "dena1",
          name_ja: "DeNA1銀行",
          name_en: "Bank of DeNA1",
          email_domain: "dena.jp",
          cash_back_terms_url: "https://dena.jp/cash_back_terms",
          value_path: "dena1/value",
        }
      ],
      files: [
        { path: "dena2/value", value: "{\n  \"contact_email\": \"rerep@dena.com\"\n}" },
        { path: "dena1/value", value: "{\n  \"contact_email\": \"rerep@dena.jp\"\n}" },
      ],
    }
  }

  it 'contains exactly' do
    hash = {
      dump_json: [
        {
          unique_key: "dena1",
          name_ja: "DeNA1銀行",
          name_en: "Bank of DeNA1",
          email_domain: "dena.jp",
          cash_back_terms_url: "https://dena.jp/cash_back_terms",
          value_path: "dena1/value",
        }
      ],
      files: [
        { path: "dena1/value", value: "{\n  \"contact_email\": \"rerep@dena.jp\"\n}" },
        { path: "dena2/value", value: "{\n  \"contact_email\": \"rerep@dena.com\"\n}" },
      ],
    }

    expect(external_resources).to eql(hash)
  end

end
