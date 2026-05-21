export default {
  mounted() {
    let closeDueToAction = false
    const modal = this.el

    setTimeout(() => {
      modal.showModal()
    }, 50)

    modal.addEventListener('close', event => {
      // Circumvent ESC or outside click if not closeable
      if (!modal.dataset.closeable) {
        event.preventDefault()
        modal.showModal()
        return
      }

      // Handles the dialogs native close event.
      // This is triggered when the user clicks outside the modal or presses ESC.
      setTimeout(() => {
        if (closeDueToAction) return
        liveSocket.execJS(modal, modal.dataset.cancel)
        closeDueToAction = false
      }, 300)
    })

    modal.addEventListener('close-dialog', event => {
      // Avoid running cancel action on close
      // This event is triggered when the live patch navigates away
      closeDueToAction = true
      modal.close()
    })
  }
}