import { render } from "solid-js/web";
import { SOLID_PROPS_ATTR, SOLID_COMP_ATTR, JSX } from "./constants";

const MOUNT = "DOMContentLoaded";
const SOLID_ATTR_SELECTOR = `[${SOLID_COMP_ATTR}]`;

document.addEventListener(MOUNT, mountJsx);

function mountJsx() {
    const observer = new IntersectionObserver((entries, observer) => {
        for (const entry of entries) {
            if (!entry.isIntersecting) {
                continue;
            }

            mount(entry.target);
            observer.unobserve(entry.target);
        }
    }, {});

    const elements = document.body.querySelectorAll(SOLID_ATTR_SELECTOR);

    for (const el of elements) {
        const style = el.getAttribute('style');

        // TODO workaround for `display: contents;` issue
        if (style && style.includes('display: contents')) {
            mount(el);
        } else {
            observer.observe(el);
        }
    }
}

function mount(el) {
    const name = el.getAttribute(SOLID_COMP_ATTR);
    const Element = JSX[name];

    if (!Element) {
        console.warn(`JSX element "${name}" not found`, el);
        return;
    }

    let data = el.getAttribute(SOLID_PROPS_ATTR);
    try {
        data = data ? JSON.parse(data) : {};
    } catch (error) {
        console.error(`Error parsing data for jsx element "${name}"`, error);
        data = {};
    }

    console.debug(`Rendering JSX element "${name}"`, data);

    render(() => <Element {...data} />, el);
}
