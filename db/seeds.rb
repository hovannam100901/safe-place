# frozen_string_literal: true

require 'faker'

# create user and user_info
10.times do
  User.create!(
    email: Faker::Internet.email,
    user_name: Faker::Name.name,
    password: '123123',
    password_confirmation: '123123',
    type: %w[User Counselor].sample,
    user_info_attributes: {
      address: Faker::Address.street_address,
      date_of_birth: Faker::Date.birthday,
      profile_name: Faker::Name.name,
      gender: UserInfo.genders.keys.sample
    }
  )
end

# create confession and comment for confession
20.times do
  user = User.all.sample
  con = Confession.create!(
    tag: Faker::Lorem.words,
    content: Faker::Lorem.sentence,
    anonymous: user.anonymous,
    user_id: user.id
  )
  3.times do
    con.comments.create!(
      anonymous: user.anonymous,
      user_id: user.id,
      comment: Faker::Lorem.sentence
    )
  end
end

# create room chat
10.times do
  Room.create(
    name: Faker::Space.star_cluster,
    user_id: User.where(type: 'User').sample.id,
    counselor_id: Counselor.all.sample.id,
    status: User.statuses.keys.sample
  )
end

# create podcastalbum and podcast
20.times do
  album = PodcastAlbum.create(
    name: Faker::Music.album,
    user_id: User.all.sample.id
  )
  3.times do
    Podcast.create(
      name: Faker::Music.album,
      podcast_album_id: album.id,
      author_name: Faker::Music.band,
      episode_number: Faker::Number.between(from: 1, to: 100),
      audio: File.open('/home/msi/Downloads/file_example_MP3_700KB.mp3') # change path for another file
    )
  end
end

# create like for Polymorphic(PodcastAlbum, Podcast, Confession)
5.times do
  user = User.all.sample
  album = PodcastAlbum.all.sample
  podcast = Podcast.all.sample
  confession = Confession.all.sample

  album.likes.create(
    anonymous: user.anonymous,
    user_id: user.id
  )
  podcast.likes.create(
    anonymous: user.anonymous,
    user_id: user.id
  )
  confession.likes.create(
    anonymous: user.anonymous,
    user_id: user.id
  )
end

# create bookmark for Polymorphic(PodcastAlbum, Podcast, Confession)
5.times do
  user = User.all.sample
  album = PodcastAlbum.all.sample
  podcast = Podcast.all.sample
  confession = Confession.all.sample

  album.bookmarks.create(
    anonymous: user.anonymous,
    user_id: user.id
  )
  podcast.bookmarks.create(
    anonymous: user.anonymous,
    user_id: user.id
  )
  confession.bookmarks.create(
    anonymous: user.anonymous,
    user_id: user.id
  )
end
