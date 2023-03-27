import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "query", "results", "total" ]

  search(event) {
    event.preventDefault()
    // remove existing results
    this.resultsTarget.innerHTML = "";
    this.totalTarget.innerHTML = "";
    // fetch new results from RepositoryController#search
    fetch(`/repositories/search?query=${this.queryTarget.value}`)
      .then((response) => response.json())
      .then(data => {
        if (data['error'] != null) {
          let li = document.createElement("li");
          li.innerHTML = data['error'];
          this.resultsTarget.appendChild(li);
          return;
        }
        let total = data['total'];
        let fetched_count = data['fetched_count'];
        this.totalTarget.innerHTML = `Showing ${fetched_count} of total ${total}:`;

        data['repositories'].forEach(element => {
          let li = document.createElement("li");
          let a = document.createElement("a");
          a.setAttribute("href", element['url']);
          a.innerHTML = element['name'];
          a.setAttribute("target", "_blank");
          li.appendChild(a);
          this.resultsTarget.appendChild(li);
        })
      })
  }
}
