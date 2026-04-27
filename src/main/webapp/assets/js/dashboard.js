/**
 * 
 */
function toggleMenu() {
    document.getElementById("sidebar").classList.toggle("open");
}
// Animation 
document.addEventListener("DOMContentLoaded", function () {
    const counters = document.querySelectorAll('.counter');

    counters.forEach(counter => {
        counter.innerText = '0';

        const update = () => {
            const target = +counter.getAttribute('data-target');
            const current = +counter.innerText;

            const increment = Math.ceil(target / 50);

            if (current < target) {
                counter.innerText = current + increment;
                setTimeout(update, 30);
            } else {
                counter.innerText = target;
            }
        };

        update();
    });
});
//sidebar
document.addEventListener("click", function(e) {
    const sidebar = document.getElementById("sidebar");
    const btn = document.querySelector(".menu-btn");

    if (!sidebar.contains(e.target) && !btn.contains(e.target)) {
        sidebar.classList.remove("open");
    }
});