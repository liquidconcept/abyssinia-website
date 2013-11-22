// =require jquery-ui
// =require jquery
// =require modernizr
// =require mediaelement-and-player
// =require jquery-h5validate

// using jQuery

$(function($, undefined) {
  // validation form init
  $('form').h5Validate();

  $('video, audio').mediaelementplayer(/* Options */);

  $('audio').mediaelementplayer({
      audioWidth: 200,
      // height of audio player
      audioHeight: 30
  });
});
