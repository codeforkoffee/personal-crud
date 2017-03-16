require_relative '../spec_helper.rb'

describe "events controller" do
  # C - Creating Records
  describe "GET new" do
    it "shows us a form" do
      get 'events/new'

      expect(last_response.body).to include('New Event')
    end
  end


  # R - Retrieving Records
  describe "GET index" do
    it "shows a list of all the events" do
      mentorship_meeting = Event.create(title: 'Blake google hangout', description: 'topic: interview questions and algorithm')

      get "/events"

      expect(last_response.body).to include('Blake google hangout')
    end

    it "links to each event" do
      mentorship_meeting = Event.create(title: 'Blake google hangout', description: 'topic: interview questions and algorithm')

      get "/events"

      expect(last_response.body).to include("/events/#{mentorship_meeting.id}")
    end

    it "shows a link to create a new event" do
      get "/events"

      expect(last_response.body).to include("New Event")
      expect(last_response.body).to include("/events/new")
    end

    it "shows a link to the edit option" do
      mentorship_meeting = Event.create(title: 'Blake google hangout', description: 'topic: interview questions and algorithm')

      get "/events/#{mentorship_meeting.id}"

      expect(last_response.body).to include("/events/#{mentorship_meeting.id}/edit")
    end
  end
  # U - Updating Records
  describe "GET edit" do
    it "loads information from the existing record" do

      mentorship_meeting = Event.create(title: 'Blake google hangout', description: 'topic: interview questions and algorithm')

      get "events/#{mentorship_meeting.id}/edit"

      expect(last_response.body).to include("Edit Event")
      expect(last_response.body).to include(mentorship_meeting.title)
    end
  end

  describe "POST update" do
    it "edits the existing record" do

      mentorship_meeting = Event.create(title: 'Blake google hangout', description: 'topic: interview questions and algorithm')

      params = { title: "updated plan" , description: "we are going to get lunch" }

      put "events/#{mentorship_meeting.id}", params
      mentorship_meeting.reload

      expect(mentorship_meeting.title).to eq("updated plan")
    end

    it "redirects back to the show page" do
      mentorship_meeting = Event.create(title: 'Blake google hangout', description: 'topic: interview questions and algorithm')

      params = { title: "updated plan" , description: "we are going to get lunch" }

      put "events/#{mentorship_meeting.id}", params

      expect(last_response.status).to eq(302)
      expect(last_response.location).to match(/events\/#{mentorship_meeting.id}/)
    end
  end

  # D - Deleting

  describe "SHOW destroy" do
    it 'displays the delet option on the SHOW page' do

      mentorship_meeting = Event.create(title: 'Blake google hangout', description: 'topic: interview questions and algorithm')

      get "/events/#{mentorship_meeting.id}"

      expect(last_response.body).to include('Delete')
    end
  end

  describe "DELETE destroy" do
    it "deletes the existing event" do

      mentorship_meeting = Event.create(title: 'Blake google hangout', description: 'topic: interview questions and algorithm')

      expect {
        delete "/events/#{mentorship_meeting.id}"
      }.to change {
        Event.count
      }.by(-1)
    end
  end

end
