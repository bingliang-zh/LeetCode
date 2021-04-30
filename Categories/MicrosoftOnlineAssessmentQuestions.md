- [1647. Minimum Deletions to Make Character Frequencies Unique](#1647-minimum-deletions-to-make-character-frequencies-unique)

[Microsoft Online Assessment Questions](https://leetcode.com/discuss/interview-question/398023/Microsoft-Online-Assessment-Questions)

### 1647. Minimum Deletions to Make Character Frequencies Unique

A string s is called good if there are no two different characters in s that have the same frequency.

Given a string s, return the minimum number of characters you need to delete to make s good.

The frequency of a character in a string is the number of times it appears in the string. For example, in the string "aab", the frequency of 'a' is 2, while the frequency of 'b' is 1.

```ts
// using sort
function minDeletions(s: string): number {
    const ACharCode = 'a'.charCodeAt(0);
    // string -> sorted frequencies
    const frequencies = new Array<number>(26).fill(0);

    for (let i = 0; i < s.length; i++) {
        const index = s[i].charCodeAt(0) - ACharCode
        frequencies[index] = frequencies[index] + 1;
    }

    frequencies.sort((a, b) => {
        return b - a;
    }) // descending

    let deleteCount = 0;
    for (let i = 1; frequencies[i] > 0 && i < 26; i++) {
        if (frequencies[i] >= frequencies[i - 1]) {
            const target = Math.max(frequencies[i - 1] - 1, 0);
            deleteCount += frequencies[i] - target;
            frequencies[i] = target;
        }
    }
    return deleteCount;
};
```

```ts
// greedy
function minDeletions(s: string): number {
    const ACharCode = 'a'.charCodeAt(0);
    const frequencies = new Array<number>(26).fill(0);

    for (let i = 0; i < s.length; i++) {
        const index = s[i].charCodeAt(0) - ACharCode
        frequencies[index] = frequencies[index] + 1;
    }

    const usedFrequencies = new Set<number>();

    let deleteCount = 0;
    for (let i = 0; i < frequencies.length; i++) {
        let freq = frequencies[i];
        while (usedFrequencies.has(freq) && freq > 0) {
            deleteCount++;
            freq--;
        }
        usedFrequencies.add(freq);
    }
    return deleteCount;
};
```