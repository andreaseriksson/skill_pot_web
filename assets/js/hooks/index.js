import Modal from "./modal"

let Hooks = {}

Hooks.Focus = {
  mounted() {
    this.el.focus()
  }
}

Hooks.Modal = Modal

export {Hooks}