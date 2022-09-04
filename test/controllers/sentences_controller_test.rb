require "test_helper"

class SentencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sentence = sentences(:hello_world)
  end

  test "should get index" do
    get sentences_url
    assert_response :success
  end

  test "should get new" do
    get new_sentence_url
    assert_response :success
  end

  test "should create sentence" do
    assert_difference('Sentence.count', 1) do
      post sentences_url, params: { sentence: { text: @sentence.text } }
    end

    assert_redirected_to sentence_url(Sentence.last)
  end

  test "should create sentence and any entities added - string" do
    assert_difference('Sentence.count', 1) do
      post sentences_url, params: { sentence: {
        text: @sentence.text,
        entities_attributes: {
          rand(50000) => {
            text: "beginning of",
            type: "start"
          }
        }
      }}
    end
    created_sentence = Sentence.last
    assert_redirected_to sentence_url(created_sentence)
    assert_equal(created_sentence.entities.count, 1)
    assert_equal(created_sentence.entities.first.text, "beginning of")
    assert_equal(created_sentence.entities.first.type, "START")
  end

  test "should create sentence and any entities added - array" do
    assert_difference('Sentence.count', 1) do
      post sentences_url, params: { sentence: {
        text: @sentence.text,
        entities_attributes: {
          rand(50000) => {
            text: "ending of",
            type: "end"
          }
        }
      }}
    end
    created_sentence = Sentence.last
    assert_redirected_to sentence_url(created_sentence)
    assert_equal(created_sentence.entities.count, 1)
    assert_equal(created_sentence.entities.first.text, "ending of")
    assert_equal(created_sentence.entities.first.type, "END")
  end

  test "should show sentence" do
    get sentence_url(@sentence)
    assert_response :success
  end

  test "should get edit" do
    get edit_sentence_url(@sentence)
    assert_response :success
  end

  test "should update sentence" do
    patch sentence_url(@sentence), params: { sentence: { text: @sentence.text } }
    assert_redirected_to sentence_url(@sentence)
  end

  test "should destroy sentence and any related sentence entities" do
    SentencesEntity.create(entity: entities(:hello), sentence: @sentence)
    assert_difference('Sentence.count', -1) do
      assert_difference('SentencesEntity.count', -1) do
        delete sentence_url(@sentence)
      end
    end

    assert_redirected_to sentences_url
  end
end
