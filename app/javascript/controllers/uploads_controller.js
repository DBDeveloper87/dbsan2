import { Controller } from "@hotwired/stimulus"
import { DirectUpload } from "@rails/activestorage"
import * as bootstrap from "bootstrap"

export default class extends Controller {
  static targets = [ "uploadButtonFrame",
    "file_list", "for", "for_id", "inputId", "submit", "collapseButton", "collapseButtonIcon", 
    "inputFields", "list", "blob_info", "progress_text", "progressbar"
   ]

  connect() {
    if (this.data.get("grab") == "input") {
      this.inputFieldsTarget.appendChild(document.getElementById(this.data.get("input-id")))      
    }
    if (this.data.get("grab") == "item") {
      const list_index = Number(this.data.get("item"))
      const input = this.data.get("input")
      this.uploadFile(input, list_index)
    }
    this.tooltips()
  }

  tooltips() {
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl)
    })
  }

  expandCollapse() {
    if (this.collapseButtonIconTarget.classList.contains("bi-chevron-compact-down")) {
      this.collapseButtonIconTarget.classList.remove("bi-chevron-compact-down")
      this.collapseButtonIconTarget.classList.add("bi-chevron-compact-up")
      const tooltip = bootstrap.Tooltip.getInstance(this.collapseButtonIconTarget)
      this.collapseButtonIconTarget.setAttribute("data-bs-title", "Expand")
      tooltip.setContent({ '.tooltip-inner': 'Expand' })
    } else {
      this.collapseButtonIconTarget.classList.remove("bi-chevron-compact-up")
      this.collapseButtonIconTarget.classList.add("bi-chevron-compact-down")
      const tooltip = bootstrap.Tooltip.getInstance(this.collapseButtonIconTarget)
      this.collapseButtonIconTarget.setAttribute("data-bstitle", "Collapse")
      tooltip.setContent({ '.tooltip-inner': 'Collapse' })
    }
  }

  createRecords() {
    this.uploadButtonFrameTarget.classList.add("d-none")
    const file_field = this.data.get("file-field")
    const files = Array.from(document.getElementById(file_field).files)
    
    var file_list = []
    files.forEach((file, index) => {
      file_list.push({
        list_index: index,
        name: file.name,
        size: file.size,
        type: file.type,
        status: "awaiting upload"
      })
    })
    this.file_listTarget.value = JSON.stringify(file_list)
    this.forTarget.value = this.data.get("for")
    this.inputIdTarget.value = file_field
    this.submitTarget.click()  
  }

  uploadFile(input, list_index) {
    addEventListener("direct-upload:progress", (event) => {
      const {id, progress } = event.detail
      alert(progress)
    })
    const file_field = document.getElementById(input)
    const url = file_field.dataset.directUploadUrl
    const files = Array.from(file_field.files)
    
    files.forEach((file, index) => {
      if (index == list_index) {
        const upload = new DirectUpload(file, url, this)

        upload.create((error, blob) => {
          if (error) {
            alert(error)
          } else {
            this.blob_infoTarget.value = JSON.stringify({
              list_index: list_index,
              blob_id: blob.signed_id
            })
            this.submitTarget.click()
          }
        })
      }
    })  
  }

  directUploadWillStoreFileWithXHR(request) {
    request.upload.addEventListener("progress", (event) => {
      this.progressUpdate(event)
    })
  }

  progressUpdate(event) {
    const progress = (event.loaded / event.total) * 100
    this.progressbarTarget.style.width = String(progress) + "%"
  }
}