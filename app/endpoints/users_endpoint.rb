module PaperStash
  class UsersEndpoint < PaperStash::Endpoint
    get '/v1/users' do
      authorize! :read, User
      halt 501
    end

    get '/v1/users/:user' do |user_id|
      user = User.with_pk!(user_id)
      authorize! :read, user
      serialize UserSerializer.new(user)
    end

    get '/v1/users/:user/activity' do |user_id|
      user = User.with_pk!(user_id)
      authorize! :read, user
      # TODO(mtwilliams): Sort, ascending by age.
      # TODO(mtwilliams): Paginate.
      activity = user.activity.all
      serialize UserActivitySerializer.for_collection.new(activity)
    end
  end
end
