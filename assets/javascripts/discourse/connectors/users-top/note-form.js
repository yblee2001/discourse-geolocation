import Component from "@ember/component";
import { ajax } from "discourse/lib/ajax";
import { getOwner } from '@ember/application';


export default Component.extend({
  title: "",
  content: "",
  keyword: "",
  latitude: "",
  longitude: "",
  user_id: "",

  init() {
    this._super(...arguments);
    const currentUser = getOwner(this).lookup("service:current-user");
    this.set("user_id", currentUser?.id || null);
  },

  actions: {
    onSubmitNote() {
      console.log("on submit note!");
      this.getLocation()
        .then(({ longitude, latitude }) => {
          console.log('Got location:', latitude, longitude);
          this.saveNoteWithLocation(latitude, longitude);
        })
        .catch((error) => {
          console.error(error.message);
        });
    },
  },

  //deprecated
  getUser() {
    const currentUser = getOwner(this).lookup('service:current-user');
    console.log(currentUser.id, currentUser.username);
    this.set("user_id", currentUser.id || null);
    return this.user_id;
  },

  getLocation() {
    return new Promise((resolve, reject) => {
      if (!navigator.geolocation) {
        console.log("Geolocation is not supported by this browser.");
        return;
      }

      console.log('Calling getCurrentPosition...');

      navigator.geolocation.getCurrentPosition(
        (position) => {
          const longitude = position.coords.longitude;
          const latitude = position.coords.latitude;
          console.log(latitude, longitude);

          resolve({ longitude, latitude })
        },
        (error) => {
          reject(new Error("Error fetching location: " + error.message))
        },
        { enableHighAccuracy: false }
      )
    });
  },

  saveNoteWithLocation(longitude, latitude) {
    ajax("/notes", {
      type: "POST",
      data: {
        title: 'TITLE',
        content: this.keyword,
        longitude,
        latitude,
        user_id: this.user_id,
      }
    }).then(() => {
      alert("키워드가 저장었습니다!");
      this.resetForm();
    }).catch((e) => {
      console.log("Error saving note to backend: ", e)
    });
  },

  resetForm() {
    this.set("title", "");
    this.set("content", "");
    this.set("keyword", "")
  },

});

