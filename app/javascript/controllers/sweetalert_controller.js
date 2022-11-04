import Swal from 'sweetalert2'
import { Controller } from "@hotwired/stimulus"
// import 'animate.css';
// Connects to data-controller="sweetalert"
export default class extends Controller {
  static values = { title: String }

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
        popup: 'round-4 color-bg-sweet',
      },
      buttonsStyling: false
    })

    swalWithBootstrapButtons.fire({
      imageUrl: 'https://i.gifer.com/origin/6e/6e9883667103218ba64b5739f5b10b5f.gif',
      title: "Are you sure of delete" + " " + this.titleValue + "?",
      text: "You won't be able to revert this!",
      showCancelButton: true,
      confirmButtonText: 'Yes, delete it!',
      cancelButtonText: 'No, cancel!',
      showCloseButton: true,
      showClass: {
        popup: 'animate__animated animate__bounceInUp'
      },
      hideClass: {
        popup: 'animate__animated animate__bounceOutUp'
      },
    }).then((result) => {
      if (result.isConfirmed) {
        this.redirect = true;
        this.element.click();
      }
      else{
        swalWithBootstrapButtons.fire({
          icon: 'error',
          title: 'Cancelled!',
          showConfirmButton: false,
          timer: 500,
          hideClass: {
            popup: 'animate__animated animate__bounceOutUp'
          }
        })
      }
    })
  }
}
