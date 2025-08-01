import Component from "@ember/component";

export default Component.extend({
  tagName: "div",
  classNames: ["my-custom-component"],

  init() {
    this._super(...arguments);
    console.log("My Custom Component Initialized");
    document.getElementById('my-button').addEventListener(
      'click',
      () => console.log('Component initialized successfully!')
    )
  },

  handleClick() {
    // console.log('hello...')
    // alert("커스텀 컴포넌트 버튼 클릭!");
  },

  actions: {
    handleClick(event) {
      console.log('hello world')
    }
  },
});
