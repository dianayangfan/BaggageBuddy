import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-dropdown"
export default class extends Controller {
  static targets = ["query", "results"];

  connect() {
    console.log("Hello from the search dropdown controller!")
  }

   search() {
    const query = this.queryTarget.value;
    console.log("Query:", query);
    if (query.length < 1) {
      this.resultsTarget.innerHTML = "";
      this.resultsTarget.style.display = "none"; // Hide dropdown if query is too short
      return;
    }

    fetch(`/search_suggestions?query=${query}`)
    .then(response => {
      console.log("Raw response:", response);
      return response.json();
    })
      .then(data => {
        console.log("Data received:", data);
        if (data.length > 0) {
          this.resultsTarget.innerHTML = data.map(airline => `
            <div class="dropdown-item" data-action="click->search-dropdown#select" data-id="${airline.id}">
              ${airline.name}
            </div>
          `).join("");
          this.resultsTarget.style.display = "block"; // Show dropdown if there are results
        } else {
          this.resultsTarget.innerHTML = "";
          this.resultsTarget.style.display = "none"; // Hide dropdown if no results
        }
      })
      .catch(error => {
        console.error("Error fetching search suggestions:", error);
        this.resultsTarget.style.display = "none"; // Hide dropdown if there's an error
      });
  }

  select(event) {
    const id = event.currentTarget.dataset.id;
    window.location.href = `/airlines/${id}`;
  }
}
