import { render } from "solid-js/web";
import { SOLID_PROPS_ATTR, SOLID_COMP_ATTR, COMPONENTS } from "./constants";

const MOUNT = "DOMContentLoaded";
const SOLID_ATTR_SELECTOR = `[${SOLID_COMP_ATTR}]`;


document.addEventListener(MOUNT, function mountComponents() {
    const elements = document.querySelectorAll(SOLID_ATTR_SELECTOR);

    for (const el of elements) {
        const name = el.getAttribute(SOLID_COMP_ATTR);
        const Component = COMPONENTS[name];

        if (!Component) {
            console.error(`Component "${name}" not found`, el);
            continue;
        }

        let data = el.getAttribute(SOLID_PROPS_ATTR);
        const exists = typeof data === 'string' && data.length > 0;
        try {
            data = exists ? JSON.parse(data) : {};
        } catch (error) {
            console.error(`Error parsing data for component "${name}":`, error);
        }

        render(() => <Component {...data} />, el);
    }
});
