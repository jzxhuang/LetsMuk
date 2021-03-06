require 'test_helper'

class TimeBlocksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @time_block = time_blocks(:one)
  end

  test "should get index" do
    get time_blocks_url, as: :json
    assert_response :success
  end

  test "should create time_block" do
    assert_difference('TimeBlock.count') do
      post time_blocks_url, params: { time_block: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show time_block" do
    get time_block_url(@time_block), as: :json
    assert_response :success
  end

  test "should update time_block" do
    patch time_block_url(@time_block), params: { time_block: {  } }, as: :json
    assert_response 200
  end

  test "should destroy time_block" do
    assert_difference('TimeBlock.count', -1) do
      delete time_block_url(@time_block), as: :json
    end

    assert_response 204
  end
end
