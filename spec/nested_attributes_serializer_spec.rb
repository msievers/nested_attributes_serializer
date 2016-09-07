require "active_record"
require "fileutils"

SQLITE_DATABASE = File.join(gem_root, "tmp", "test.db")

describe NestedAttributesSerializer do
  before(:context) do
    Dir.mkdir File.dirname(SQLITE_DATABASE) rescue Errno::EEXIST
    File.delete(SQLITE_DATABASE) rescue Errno::ENOENT

    ActiveRecord::Base.establish_connection(
      :adapter => "sqlite3",
      :database => SQLITE_DATABASE
    )

    class CreateSearches < ActiveRecord::Migration[5.0]
      def change
        create_table :searches do |t|
          t.timestamps
        end
      end
    end

    CreateSearches.migrate(:up)

    class CreateQueries < ActiveRecord::Migration[5.0]
      def change
        create_table :queries do |t|
          t.text :query

          t.timestamps
        end

        add_reference :queries, :search, foreign_key: true
      end
    end

    CreateQueries.migrate(:up)

    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end

    class Search < ApplicationRecord
      include NestedAttributesSerializer

      has_many :queries

      accepts_nested_attributes_for :queries
    end

    class Query < ApplicationRecord
      belongs_to :search
    end
  end

  let(:search) do
    Search.new(queries_attributes: [{query: "foo"}])
  end

  let(:serialized_search) do
    {
      "id"=>nil, "created_at"=>nil, "updated_at"=>nil
    }
  end

  let(:serialized_search_including_queries) do
    {
      "id"=>nil, "created_at"=>nil, "updated_at"=>nil,
      "queries_attributes"=>[
        { "id"=>nil, "query"=>"foo", "created_at"=>nil, "updated_at"=>nil, "search_id"=>nil }
      ]
    }
  end

  describe "#to_nested_attributes" do
    it "serializes a model" do
      expect(search.to_nested_attributes).to eq(serialized_search)
    end

    it "includes given associations while respecting rails naming convention" do
      expect(search.to_nested_attributes(include: :queries)).to eq(serialized_search_including_queries)
    end
  end
end
