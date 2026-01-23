import {Controller} from '@hotwired/stimulus'

export default class extends Controller {
    confirm(event) {
        const confirmation = confirm('Are you sure you want to perform this action?');

        if (!confirmation)
            event.preventDefault();
    }
}