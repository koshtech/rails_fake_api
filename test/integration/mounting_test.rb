require 'test_helper'
require 'fileutils'

TEST_FILE_PATH_INTEGRATION_MINITEST = Rails.root.join('tmp', 'test_fake_data_integration_minitest')

class RailsFakeApi::MountingTest < ActionDispatch::IntegrationTest
  setup do
    FileUtils.mkdir_p(TEST_FILE_PATH_INTEGRATION_MINITEST) unless File.exist?(TEST_FILE_PATH_INTEGRATION_MINITEST)
    FileUtils.rm_f(Dir.glob(TEST_FILE_PATH_INTEGRATION_MINITEST.join('*.json')))

    RailsFakeApi::JsonFileStore.stubs(:file_path_prefix).returns(TEST_FILE_PATH_INTEGRATION_MINITEST)
  end

  teardown do
    FileUtils.rm_rf(TEST_FILE_PATH_INTEGRATION_MINITEST) if File.exist?(TEST_FILE_PATH_INTEGRATION_MINITEST)
  end

  test "GET /fake_api/:resource_name responds with JSON from the mounted engine" do
    data = [{ 'id' => 10, 'name' => 'Integration Item' }]
    RailsFakeApi::JsonFileStore.write('integration_resources', data)

    get '/fake_api/integration_resources'
    assert_response :ok
    assert_equal data, JSON.parse(response.body)
  end

  test "POST /fake_api/:resource_name creates a new resource via the mounted engine" do
    post '/fake_api/integration_posts', params: { title: 'New Integration Post' }, as: :json
    assert_response :created
    assert_equal 'New Integration Post', JSON.parse(response.body)['title']
    assert_equal 1, RailsFakeApi::JsonFileStore.read('integration_posts').length
  end

  test "invalid route should return 404 Not Found" do
    get '/fake_api/non_existent_route/123'
    assert_response :not_found
  end
end
