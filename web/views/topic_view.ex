defmodule Discuss.TopicView do
    use Discuss.Web, :view

    def belongs_to_user(topic, user) do
        user && topic.user_id == user.id
    end
end