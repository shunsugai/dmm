# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Dmm::Result do

  before do
    @dmm = Dmm.new(:api_id => ENV['API_ID'], :affiliate_id => ENV['AFFILIATE_ID'])
  end

  context 'has no item' do

    subject { @dmm.item_list(:keyword => 'ほげほげほげ').result }

    its(:result_count) { should eq 0 }
    its(:total_count) { should eq 0 }
    its(:first_position) { should eq 0 }

    describe '#items' do
      it { subject.items.should be_empty }
    end
  end

  context 'has a item' do

    subject { @dmm.item_list(:hits => 1).result }

    its(:result_count) { should eq 1 }

    describe '#items' do
      its(:items) { should have_exactly(1).items }
      it 'should include an instance of Dmm::Item' do
        subject.items.first.should be_an_instance_of Dmm::Item
      end
    end
  end

  context 'has some items' do

    subject { @dmm.item_list(:keyword => '吉川あいみ').result }

    describe '#items' do
      its(:items) { should have_at_least(1).items }
      it 'should include an instance of Dmm::Item' do
        subject.items.sample.should be_an_instance_of Dmm::Item
      end
    end
  end
end