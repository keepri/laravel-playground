import { createSignal } from 'solid-js';

export function Counter(props) {
    const [count, setCount] = createSignal(props.initial ?? 0);

    function handleClick() {
        setCount(count() + 1);
    }

    return (
        <>
            <p>Count: {count()}</p>
            <button onClick={handleClick}>
                Increment
            </button>
        </>
    );
}
