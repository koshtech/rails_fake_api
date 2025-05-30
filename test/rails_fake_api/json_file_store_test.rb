require 'test_helper'
require 'fileutils'

TEST_FILE_PATH = Rails.root.join('tmp', 'test_fake_data_minitest')

class RailsFakeApi::JsonFileStoreTest < ActiveSupport::TestCase

  setup do
    FileUtils.mkdir_p(TEST_FILE_PATH) unless File.exist?(TEST_FILE_PATH)
    FileUtils.rm_f(Dir.glob(TEST_FILE_PATH.join('*.json')))

    RailsFakeApi::JsonFileStore.define_singleton_method(:file_path_prefix) do
      TEST_FILE_PATH
    end
  end

  teardown do
    FileUtils.rm_rf(TEST_FILE_PATH) if File.exist?(TEST_FILE_PATH)
  end

  test 'read returns an empty array if the file does not exist' do
    assert_equal [], RailsFakeApi::JsonFileStore.read('non_existent_resource')
  end

  test 'read returns an empty array if the JSON is invalid' do
    File.open(TEST_FILE_PATH.join('invalid.json'), 'w') { |f| f.write('{"key": "value"}}') }
    assert_equal [], RailsFakeApi::JsonFileStore.read('invalid')
  end

  test 'read reads data from an existing JSON file' do
    data = [{ 'id' => 1, 'name' => 'Test' }]
    File.open(TEST_FILE_PATH.join('valid.json'), 'w') { |f| f.write(JSON.generate(data)) }
    assert_equal data, RailsFakeApi::JsonFileStore.read('valid')
  end

  test 'write writes data to a JSON file' do
    data = [{ 'id' => 1, 'name' => 'New Item' }]
    RailsFakeApi::JsonFileStore.write('new_resource', data)
    assert_equal data, JSON.parse(File.read(TEST_FILE_PATH.join('new_resource.json')))
  end

  test 'write overwrites existing data in the file' do
    existing_data = [{ 'id' => 1, 'name' => 'Old Item' }]
    File.open(TEST_FILE_PATH.join('overwrite_resource.json'), 'w') { |f| f.write(JSON.generate(existing_data)) }

    new_data = [{ 'id' => 2, 'name' => 'Overwritten Item' }]
    RailsFakeApi::JsonFileStore.write('overwrite_resource', new_data)
    assert_equal new_data, JSON.parse(File.read(TEST_FILE_PATH.join('overwrite_resource.json')))
  end

  test 'find finds an item by ID' do
    data = [{ 'id' => 1, 'name' => 'Item 1' }, { 'id' => 2, 'name' => 'Item 2' }]
    RailsFakeApi::JsonFileStore.write('find_resource', data)
    assert_equal({ 'id' => 1, 'name' => 'Item 1' }, RailsFakeApi::JsonFileStore.find('find_resource', 1))
  end

  test 'find returns nil if item is not found' do
    data = [{ 'id' => 1, 'name' => 'Item 1' }]
    RailsFakeApi::JsonFileStore.write('find_resource', data)
    assert_nil RailsFakeApi::JsonFileStore.find('find_resource', 99)
  end

  test 'find handles string IDs correctly' do
    data = [{ 'id' => 1, 'name' => 'Item 1' }]
    RailsFakeApi::JsonFileStore.write('find_resource', data)
    assert_equal({ 'id' => 1, 'name' => 'Item 1' }, RailsFakeApi::JsonFileStore.find('find_resource', '1'))
  end

  test 'next_id returns 1 if the resource file is empty' do
    RailsFakeApi::JsonFileStore.write('empty_resource', [])
    assert_equal 1, RailsFakeApi::JsonFileStore.next_id('empty_resource')
  end

  test 'next_id returns 1 if the resource file does not exist' do
    assert_equal 1, RailsFakeApi::JsonFileStore.next_id('non_existent_resource_for_id')
  end

  test 'next_id returns the next available ID based on existing data' do
    data = [{ 'id' => 1, 'name' => 'Item 1' }, { 'id' => 3, 'name' => 'Item 3' }]
    RailsFakeApi::JsonFileStore.write('next_id_resource', data)
    assert_equal 4, RailsFakeApi::JsonFileStore.next_id('next_id_resource')
  end
end
