import Swal from 'sweetalert2'
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sweetalert"
export default class extends Controller {

  connect(){
    this.redirect = false;
  }

  show(event){

    if (this.redirect) return;


    event.stopImmediatePropagation();
    event.preventDefault();
    const swalWithBootstrapButtons = Swal.mixin({
      customClass: {
        confirmButton: 'btn btn-danger me-2 rounded-pill',
        cancelButton: 'btn btn-success ms-2 rounded-pill',
        popup: 'round-4',
      },
      buttonsStyling: false
    })

    swalWithBootstrapButtons.fire({
      imageUrl: 'https://i.gifer.com/origin/6e/6e9883667103218ba64b5739f5b10b5f.gif',
      title: 'Are you sure?',
      text: "You won't be able to revert this!",
      showCancelButton: true,
      confirmButtonText: 'Yes, delete it!',
      cancelButtonText: 'No, cancel!',
      showCloseButton: true,
    }).then((result) => {
      if (result.isConfirmed) {
        this.redirect = true
        this.element.click();
      }
    })
  }
}
