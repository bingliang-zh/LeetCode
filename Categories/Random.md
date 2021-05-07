### 1041. Robot Bounded In Circle

```ts
function isRobotBounded(instructions: string): boolean {
    let direction = 0; // 0 north, 1 east, 2 south, 3 west
    const position = {x: 0, y: 0};
    for (let i = 0; i < instructions.length; i++) {
        if (instructions[i] === 'L') direction += 3;
        else if (instructions[i] === 'R') direction++;
        else {
            const offset = {x: 0, y: 0};
            switch (direction % 4) {
                case 0: offset.y = 1; break;
                case 1: offset.x = 1; break;
                case 2: offset.y = -1; break;
                case 3: offset.x = -1; break;
            }
            position.x += offset.x;
            position.y += offset.y;
        }
    }
    switch (direction % 4) {
        case 0:
            return !(position.x !== 0 || position.y !== 0);
        default:
            return true;
    }
};
```

### 68. Text Justification

```ts
function fullJustify(words: string[], maxWidth: number): string[] {
    const lines: string[][] = [];

    let currentLine = [];
    let currentLineLength = 0;
    for (let i = 0; i < words.length; i++) {
        if (currentLineLength === 0) {
            currentLine.push(words[i]);
            currentLineLength = words[i].length;
        } else {
            if (currentLineLength + words[i].length + 1 > maxWidth) {
                // new line
                lines.push(currentLine);
                currentLine = [words[i]];
                currentLineLength = words[i].length;
            } else {
                currentLine.push(words[i]);
                currentLineLength += words[i].length + 1;
            }
        }
    }

    lines.push(currentLine);

    return lines.map((words, index) => {
        if (index !== lines.length - 1) {
            if (words.length === 1) {
                let result = words[0];
                while (result.length !== maxWidth) {
                    result += ' ';
                }
                return result;
            }
            let characterCount = 0;
            for (let i = 0; i < words.length; i++) {
                characterCount += words[i].length;
            }
            let result = '';
            let spaceCount = maxWidth - characterCount;
            let gapCount = words.length - 1;
            for (let i = 0; i < words.length; i++) {
                let nextSpaces = Math.ceil(spaceCount / gapCount);
                gapCount--;
                spaceCount -= nextSpaces;
                result += words[i];
                while (nextSpaces > 0) {
                    result += ' ';
                    nextSpaces--;
                }
            }
            return result;
        } else {
            // last line
            let result = words[0];
            for (let i = 1; i < words.length; i++) {
                result += ' ' + words[i];
            }
            while (result.length < maxWidth) {
                result += ' ';
            }
            return result;
        }
    })
};
```

### 1396. Design Underground System

```ts
class UndergroundSystem {
    passengers: Map<number, {stationName: string, t: number}>; // 1 -> {station: 'Leyton', t: 23}
    avgTime: Map<string, {avg: number, sampleCount: number}>; // 'Leyton,Paradise' -> {avg: 10, sampleCount: 2};

    constructor() {
        this.passengers = new Map;
        this.avgTime = new Map;
    }

    checkIn(id: number, stationName: string, t: number): void {
        this.passengers.set(id, {stationName, t});
    }

    checkOut(id: number, stationName: string, t: number): void {
        const {stationName: stationNameIn, t: tIn} = this.passengers.get(id);
        this.passengers.delete(id);
        const key = stationNameIn + ',' + stationName;
        const duration = t - tIn;
        if (!this.avgTime.has(key)) {
            this.avgTime.set(key, {avg: duration, sampleCount: 1});
        } else {
            const node = this.avgTime.get(key);
            node.avg = (node.avg * node.sampleCount + duration) / (node.sampleCount + 1);
            node.sampleCount++;
        }
    }

    getAverageTime(startStation: string, endStation: string): number {
        // Use lazy calculation may improve performance?
        return this.avgTime.get(startStation + ',' + endStation).avg;
    }
}
```