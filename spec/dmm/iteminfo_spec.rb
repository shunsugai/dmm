#encoding: utf-8

require 'spec_helper'

describe Dmm::Iteminfo do

  describe '#method_missing' do
    subject { Dmm::Iteminfo.new({:keyword =>[{:name => "顔射", :id => "5023"},{:name =>"単体作品", :id =>"4025"},{:name =>"美少女", :id =>"1027"}],:series => {:name => "絶対的美少女、お貸しします。", :id => "79983"},:maker => {:name => "プレステージ", :id => "40136"},:actress =>[{:name => "あやみ旬果", :id => "1016835"},{:name => "あやみしゅんか", :id => "1016835_ruby"},{:name => "av", :id => "1016835_classify"}],:label => {:name => "ます。", :id => "20940"}})}

    context 'with argument :keyword' do
      its(:keyword) { should eq ['顔射', '単体作品', '美少女']}
    end

    context 'with argument :series' do
      its(:series) { should eq '絶対的美少女、お貸しします。' }
    end

    context 'with argument :maker' do
      its(:maker) { should eq 'プレステージ' }
    end

    context 'with argument :actress' do
      its(:actress) { should eq ['あやみ旬果'] }
    end

    context 'with argument :director' do
      its(:director) { should be_nil }
    end

    context 'with argument :label' do
      its(:label) { should eq 'ます。' }
    end

    context 'with argument :undefined_method' do
      it { proc{ subject.undefined_method }.should raise_error NoMethodError }
    end
  end

  describe '#keyword' do
    context 'has one keyword' do
      subject { Dmm::Iteminfo.new(:keyword => {:name => "顔射"}) }

      its(:keyword) { should eq ['顔射'] }
    end
    context 'has no keyword' do
      subject { Dmm::Iteminfo.new }
      its(:keyword) { should be_nil }
    end
  end

  describe '#respond_to?' do
    subject { Dmm::Iteminfo.new }
    it 'return true with argument :keyword' do
      subject.respond_to?(:keyword).should be_true
    end
  end
end