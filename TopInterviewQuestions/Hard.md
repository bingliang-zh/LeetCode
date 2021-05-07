
## Dynamic Programming

### Maximum Product Subarray

TODO

### Decode Ways

```ts
function numDecodings(s: string): number {
    const cache = new Array<number>(s.length);

    cache[0] = s[0] === '0' ? 0 : 1;

    for (let i = 1; i < s.length; i++) {
        const singleGood = s[i] !== '0';
        const twinGood = s[i - 1] === '0' ? false : (Number(s[i - 1]) * 10 + Number(s[i])) <= 26;
        cache[i] = 0;
        if (singleGood) cache[i] += cache[i - 1];
        if (twinGood) cache[i] += i === 1 ? 1 : cache[i - 2];
    }
    return cache[cache.length - 1];
};
```