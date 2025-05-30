require 'test_helper'
require 'fileutils'

TEST_FILE_PATH_CONTROLLER = Rails.root.join('tmp', 'test_fake_data_controller_minitest')

class RailsFakeApi::FakeApiControllerTest < ActionDispatch::IntegrationTest
  include Rails.application.routes.url_helpers

  setup do
    FileUtils.mkdir_p(TEST_FILE_PATH_CONTROLLER) unless File.exist?(TEST_FILE_PATH_CONTROLLER)
    FileUtils.rm_f(Dir.glob(TEST_FILE_PATH_CONTROLLER.join('*.json')))

    RailsFakeApi::JsonFileStore.stubs(:file_path_prefix).returns(TEST_FILE_PATH_CONTROLLER)
  end

  teardown do
    FileUtils.rm_rf(TEST_FILE_PATH_CONTROLLER) if File.exist?(TEST_FILE_PATH_CONTROLLER)
  end

  test 'GET /fake_api/:resource_name should return a list of resources' do
    data = [{ 'id' => 1, 'title' => 'Post 1' }]
    RailsFakeApi::JsonFileStore.write('posts', data)
    get "/fake_api/posts"
    assert_response :ok
    assert_equal data, JSON.parse(response.body)
  end

  test 'GET /fake_api/:resource_name should return an empty array if no resources exist' do
    get "/fake_api/comments"
    assert_response :ok
    assert_equal [], JSON.parse(response.body)
  end

  test 'GET /fake_api/:resource_name/:id should return the specified resource when it exists' do
    data = [{ 'id' => 1, 'title' => 'Post 1' }]
    RailsFakeApi::JsonFileStore.write('posts', data)
    get "/fake_api/posts/1"
    assert_response :ok
    assert_equal({ 'id' => 1, 'title' => 'Post 1' }, JSON.parse(response.body))
  end

  test 'GET /fake_api/:resource_name/:id should return not found status when resource does not exist' do
    get "/fake_api/posts/99"
    assert_response :not_found
    assert_equal I18n.t('rails_fake_api.errors.resource_not_found'), JSON.parse(response.body)['error']
  end

  test 'POST /fake_api/:resource_name should create a new resource' do
    post "/fake_api/posts", params: { title: 'New Post', author: 'Test' }, as: :json
    assert_response :created
    response_data = JSON.parse(response.body)
    assert_not_nil response_data['id']
    assert_equal 'New Post', response_data['title']
    assert_equal 1, RailsFakeApi::JsonFileStore.read('posts').length
  end

  test 'PUT /fake_api/:resource_name/:id should update the specified resource' do
    RailsFakeApi::JsonFileStore.write('posts', [{ 'id' => 1, 'title' => 'Original', 'status' => 'draft' }])
    put "/fake_api/posts/1", params: { title: 'Updated Title', status: 'published' }, as: :json
    assert_response :ok
    response_data = JSON.parse(response.body)
    assert_equal 'Updated Title', response_data['title']
    assert_equal 'published', response_data['status']
    assert_equal 'Updated Title', RailsFakeApi::JsonFileStore.read('posts').first['title']
  end

  test 'PUT /fake_api/:resource_name/:id should return not found status when resource does not exist' do
    put "/fake_api/posts/99", params: { title: 'Non Existent' }, as: :json
    assert_response :not_found
  end

  test 'DELETE /fake_api/:resource_name/:id should delete the specified resource' do
    RailsFakeApi::JsonFileStore.write('posts', [{ 'id' => 1, 'title' => 'Post to delete' }])
    delete "/fake_api/posts/1"
    assert_response :no_content
    assert_empty RailsFakeApi::JsonFileStore.read('posts')
  end

  test 'DELETE /fake_api/:resource_name/:id should return not found status when resource does not exist' do
    delete "/fake_api/posts/99"
    assert_response :not_found
  end
end
