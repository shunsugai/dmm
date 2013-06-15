# -*- encoding: utf-8 -*-
module RequestHelper
  def get_sample_items
    time = Time.now.to_s.gsub(/\s/, '+')
    request_url = 'http://affiliate-api.dmm.com/?api_id=API_ID&affiliate_id=AFFILIATE_ID&operation=ItemList&version=2.00&timestamp=' + time + '&site=DMM.co.jp&keyword=%B5%F0%C6%FD'
    stub_request(:get, request_url).to_return(:status => 200, :body => fixture('sample2.xml'))
    client = Dmm.new(:api_id => 'API_ID', :affiliate_id => 'AFFILIATE_ID')
    client.instance_variable_set(:@time, time)
    response = client.item_list(:keyword => '巨乳')
    response.items
  end
end