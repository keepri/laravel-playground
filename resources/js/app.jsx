import { render } from "solid-js/web";

import { SOLID_DATA_ATTR, SOLID_COMP_ATTR, COMPONENTS } from "./constants";

document.querySelectorAll(`[${SOLID_COMP_ATTR}]`).forEach((el) => {
    const name = el.getAttribute(SOLID_COMP_ATTR);
    const Component = COMPONENTS[name];

    if (!Component) {
        console.error(`Component ${name} not found`, el);
        return;
    }

    let data = el.getAttribute(SOLID_DATA_ATTR);
    const exists = typeof data === 'string' && data.length > 0;
    try {
        data = exists ? JSON.parse(data) : {};
    } catch (error) {
        console.error(`Error parsing data for component ${name}:`, error);
        return;
    }


    render(() => <Component {...data} />, el);
});
