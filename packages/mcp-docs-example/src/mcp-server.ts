#!/usr/bin/env node

import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { McpServer } from '@modelcontextprotocol/sdk/server/mcp.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import { z } from 'zod';

/**
 * Resolve the installed package directory.
 * Works whether run via:
 *  - npx
 *  - node node_modules/.../server.js
 */
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

/**
 * Adjust if your structure differs.
 *
 * Expected (installed package):
 *   your-lib/
 *     dist/mcp/server.js
 *     docs/llms/*.md|*.txt|*.json
 */
const LLMS_DIR = path.resolve(__dirname, '../../docs/llms');

const PACKAGE_JSON = path.resolve(__dirname, '../../package.json');

function readPackageMeta(): { name: string; version: string } {
  try {
    const raw = fs.readFileSync(PACKAGE_JSON, 'utf8');
    const parsed = JSON.parse(raw);
    return {
      name: typeof parsed?.name === 'string' ? parsed.name : '@your-scope/your-lib',
      version: typeof parsed?.version === 'string' ? parsed.version : '0.0.0',
    };
  } catch {
    return { name: '@your-scope/your-lib', version: '0.0.0' };
  }
}

/**
 * Safety: prevent directory traversal
 */
function resolveSafeFile(name: string) {
  const resolved = path.resolve(LLMS_DIR, name);

  const rel = path.relative(LLMS_DIR, resolved);
  if (rel.startsWith('..') || path.isAbsolute(rel)) throw new Error('Invalid file path.');

  return resolved;
}

function listFiles(): string[] {
  if (!fs.existsSync(LLMS_DIR)) return [];

  return fs
    .readdirSync(LLMS_DIR)
    .filter((f) => f.endsWith('.json') || f.endsWith('.txt') || f.endsWith('.md'));
}

function readFile(name: string): string {
  const filePath = resolveSafeFile(name);

  if (!fs.existsSync(filePath)) {
    throw new Error(`File not found: ${name}`);
  }

  return fs.readFileSync(filePath, 'utf8');
}

/**
 * Create MCP server
 */
const { name: packageName, version: packageVersion } = readPackageMeta();

const server = new McpServer(
  {
    name: packageName,
    version: packageVersion,
  },
  {
    capabilities: {
      tools: {},
    },
  },
);

/**
 * Tool: list_llm_files
 */
server.registerTool(
  'list_llm_files',
  {
    description:
      'List available LLM documentation files for this installed version of the library.',
    inputSchema: z.object({}).strict(),
  },
  async () => {
    return {
      content: [
        {
          type: 'text',
          text: JSON.stringify(
            {
              files: listFiles(),
            },
            null,
            2,
          ),
        },
      ],
    };
  },
);

/**
 * Tool: get_llm_file
 */
server.registerTool(
  'get_llm_file',
  {
    description: 'Retrieve a specific LLM documentation file by filename.',
    inputSchema: z
      .object({
        filename: z.string().min(1).describe('The file name inside docs/llms/'),
      })
      .strict(),
  },
  async ({ filename }) => {
    try {
      const content = readFile(filename);

      return {
        content: [
          {
            type: 'text',
            text: content,
          },
        ],
      };
    } catch (err: unknown) {
      return {
        content: [
          {
            type: 'text',
            text: `Error: ${(err as Error).message}`,
          },
        ],
        isError: true,
      };
    }
  },
);

/**
 * Start stdio transport
 */
const transport = new StdioServerTransport();
await server.connect(transport);
