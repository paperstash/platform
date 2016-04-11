class PaperStash
  class UsersController < PaperStash::Controller
    post '/join' do
      authorize! :create, User

      param :name,                    String,  required: true
      param :nickname,                String,  required: true
      param :email,                   String,  required: true
      param :password,                String,  required: true
      param :invitation,              String,  required: true
      param :subscribe_to_newsletter, Boolean, default: true

      user = Users.join(params.split(%w(name nickname email password invitation)).symbolize_keys)
      Newsletter.subscribe(user) if params[:subscribe_to_newsletter]

      serialize UserSerializer.new(user)
    end
  end
end
