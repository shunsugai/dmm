# Dmm

Ruby wrapper for DMM Web Service API ver2

## Installation

Add this line to your application's Gemfile:

    gem 'dmm'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dmm

## Usage

### 商品情報を取得する
```ruby
client = Dmm.new(:api_id => 'your_api_id', :affiliate_id => 'your_affiliate_id')

response = client.item_list(
  :service => 'digital',
  :floor   => 'videoa',
  :hits    => 5,
  :sort    => 'rank',
  :keyword => '検索ワード')

response.items each do |item|
  puts item.title            #=> 商品名
  puts item.affiliate_url    #=> アフィリエイトURL
  puts item.sample_image_url #=> サンプル画像URL
  puts item.price_download   #=> 価格（ダウンロード）
  puts item.price_stream     #=> 価格（ストリーミング）
end
```

その他のパラメータや、他に取れそうな情報についてはこちらのサイトを参考にしてください。
https://affiliate.dmm.com/api/reference/r18/all/

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
