# frozen_string_literal: true

RSpec.describe Mihari::Analyzers::VirusTotalIntelligence, :vcr do
  context "file" do
    subject { described_class.new(query) }

    let(:query) { 'size:1KB- ls:"2021-09-18T00:00:00"' }

    describe "#title" do
      it do
        expect(subject.title).to eq("VirusTotal Intelligence search")
      end
    end

    describe "#description" do
      it do
        expect(subject.description).to eq("query = #{query}")
      end
    end

    describe "#artifacts" do
      it do
        artifacts = subject.artifacts
        expect(artifacts.all? { |artifact| Mihari::TypeChecker.type(artifact) == "hash" }).to eq(true)
      end
    end
  end

  context "url" do
    subject { described_class.new(query) }

    let(:query) { 'entity:url ls:"2021-09-18T01:00:00+" url:example' }

    describe "#artifacts" do
      it do
        artifacts = subject.artifacts
        expect(artifacts.length).to be > 0
        expect(artifacts.all? { |artifact| Mihari::TypeChecker.type(artifact) == "url" }).to eq(true)
      end
    end
  end

  context "domain" do
    subject { described_class.new(query) }

    let(:query) { "entity:domain domain:ninoseki" }

    describe "#artifacts" do
      it do
        artifacts = subject.artifacts
        expect(artifacts.length).to be > 0
        expect(artifacts.all? { |artifact| Mihari::TypeChecker.type(artifact) == "domain" }).to eq(true)
      end
    end
  end

  context "ip" do
    subject { described_class.new(query) }

    let(:query) { "entity:ip ip:167.179.69.149" }

    describe "#artifacts" do
      it do
        artifacts = subject.artifacts
        expect(artifacts.length).to be > 0
        expect(artifacts.all? { |artifact| Mihari::TypeChecker.type(artifact) == "ip" }).to eq(true)
      end
    end
  end
end
