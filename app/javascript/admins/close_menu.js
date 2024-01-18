//  a= $('')
// $('#clickopen_nav').on('click',CloseMenu())

function CloseMenu(){
    let menu = document.getElementById("left_menu")
    if (menu) {
        let displayValue = window.getComputedStyle(menu).getPropertyValue("display");
        if (displayValue != 'none')
        {
            menu.style.display = "none";
        }
        else menu.style.display = "block";
    }
}